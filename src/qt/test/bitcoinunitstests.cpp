#include "bitcoinunitstests.h"

#include "bitcoinunits.h"

#include <QUrl>

void BitcoinUnitsTests::parseTests()
{
    qint64 value = 0;

    /// Tests with en_US locale
    QLocale locale1("en_US");
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "0", &value, locale1));
    QCOMPARE(value, 0LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1", &value, locale1));
    QCOMPARE(value, 100000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1.0", &value, locale1));
    QCOMPARE(value, 100000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "10.0", &value, locale1));
    QCOMPARE(value, 1000000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1,000.0", &value, locale1));
    QCOMPARE(value, 100000000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1,000,000.0", &value, locale1));
    QCOMPARE(value, 100000000000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::Koinu, "1,000,000,000", &value, locale1));
    QCOMPARE(value, 1000000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::kBKC, "1.0", &value, locale1));
    QCOMPARE(value, 100000000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::MBKC, "1.0", &value, locale1));
    QCOMPARE(value, 100000000000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::kBKC, "0.001", &value, locale1));
    QCOMPARE(value, 100000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::MBKC, "0.000001", &value, locale1));
    QCOMPARE(value, 100000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "0.00000001", &value, locale1));
    QCOMPARE(value, 1LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::kBKC, "0.00000000001", &value, locale1));
    QCOMPARE(value, 1LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::MBKC, "0.00000000000001", &value, locale1));
    QCOMPARE(value, 1LL);
    //Without seperator
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1000.0", &value, locale1));
    QCOMPARE(value, 100000000000LL);
    //MAX_MONEY
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "10000000000", &value, locale1));
    QCOMPARE(value, 1000000000000000000LL);
    // Fail: group separator in wrong place
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "0,00", &value, locale1));
    // Fail: group separator in decimals
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "0.0,000", &value, locale1));
    // Fail: multiple decimal separators
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "0.000.000", &value, locale1));

    /// Tests with nl_NL locale
    QLocale locale2("nl_NL");
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1", &value, locale2));
    QCOMPARE(value, 100000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1,0", &value, locale2));
    QCOMPARE(value, 100000000LL);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::Koinu, "1.000.000", &value, locale2));
    QCOMPARE(value, 1000000LL);
    // Fail: multiple decimal separators
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "0,000,000", &value, locale2));

    /// Tests with de_CH locale
    QLocale locale3("de_CH");
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "123'456.78", &value, locale3));
    QCOMPARE(value, 12345678000000LL);
    // Fail: multiple decimal separators
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "0.000.000", &value, locale3));

    /// Tests with c locale
    QLocale locale4(QLocale::c());
    locale4.setNumberOptions(QLocale::OmitGroupSeparator | QLocale::RejectGroupSeparator);
    QVERIFY(BitcoinUnits::parse(BitcoinUnits::BKC, "1000.00000000", &value, locale4));
    QCOMPARE(value, 100000000000LL);
    // Fail: group separator
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "1,000.00", &value, locale4));
    // Fail: too many decimals
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "1000.000000000", &value, locale4));
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::Koinu, "1.0", &value, locale4));
    //no overflow because Bunkercoin has unlimited money supply
    /*// Fail: overflow
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "10000000000.1", &value, locale4));
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "92233720368547758090.0", &value, locale4));*/
    // Fail: underflow
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "-1000000.0", &value, locale4));
    // Fail: sign in decimals
    QVERIFY(!BitcoinUnits::parse(BitcoinUnits::BKC, "0.-1000000", &value, locale4));
}

void BitcoinUnitsTests::formatTests()
{
    /// Tests with en_US locale
    QLocale locale1("en_US");
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 0, false, false, locale1), QString("0.00000000"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 0, false, true, locale1), QString("0.00"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::kBKC, 0, false, false, locale1), QString("0.00000000000"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::MBKC, 0, false, false, locale1), QString("0.00000000000000"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::Koinu, 0, false, false, locale1), QString("0.0"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 0, true, false, locale1), QString("+0.00000000"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::Koinu, 100000000, false, true, locale1), QString("100,000,000.0"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::Koinu, 100000000, true, true, locale1), QString("+100,000,000.0"));

    QCOMPARE(BitcoinUnits::formatWithUnit(BitcoinUnits::BKC, 100000000000000LL, false, true, locale1), QString("1,000,000.00 BKC"));
    QCOMPARE(BitcoinUnits::formatWithUnit(BitcoinUnits::kBKC, 100000000000000LL, false, true, locale1), QString("1,000.00 kBKC"));
    QCOMPARE(BitcoinUnits::formatWithUnit(BitcoinUnits::MBKC, 100000000000000LL, false, true, locale1), QString("1.00 MBKC"));

    /// Tests with nl_NL locale
    QLocale locale2("nl_NL");
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 100000000000000LL, false, true, locale2), QString("1.000.000,00"));

    /// Tests with de_CH locale
    QLocale locale3("de_CH");
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 100000000000000LL, false, true, locale3), QString("1'000'000.00"));

    /// Tests with c locale (with and without group separators)
    QLocale locale4(QLocale::c());
    locale4.setNumberOptions(QLocale::OmitGroupSeparator | QLocale::RejectGroupSeparator);
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 100000000000000LL, false, true, QLocale::c()), QString("1,000,000.00"));
    QCOMPARE(BitcoinUnits::format(BitcoinUnits::BKC, 100000000000000LL, false, true, locale4), QString("1000000.00"));
}

