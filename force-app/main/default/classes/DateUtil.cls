/**
 * Class: DateUtil.cls
 * Test:  DateUtilTest.cls
 * @desc: Work in progress
 */
public class DateUtil {

    public class DateUtilException extends Exception {}

    public static String getMonthNameFromDate(Date theDate) {
        return null;
    } 

    public static String getMonthNameFromDateTime(Datetime theDateTime) {
        return getMonthNameFromDate(Date.valueOf(theDateTime));
    }

    public static String getDayNameFromDate(Date theDate) {
        return null;
    }

    public static String getDayNameFromDateTime(Datetime theDateTime) {
        return getDayNameFromDate(Date.valueOf(theDateTime));
    }

    public static Date getMondayBefore(Date theDate) {
        return null;
    }

    public static Date getSundayAfter(Date theDate) {
        return null;
    }

    public static Date getDayNumberOfWeek(Date theDate) {
        return null;
    }

}
