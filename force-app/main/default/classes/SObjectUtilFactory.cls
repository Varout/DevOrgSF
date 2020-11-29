/**
 * @class:   SObjectUtilFactory.cls
 * @test:    SObjectUtilFactoryTest.cls
 * @author:  Jason Auger
 * @desc:    A TestObjectFactory that utilises SObjectUtil to create data on the fly
 *           and with less logic in the unit test class
 * @licence: Copyright (c) 2020, Jason Auger
 *           Permission is hereby granted, free of charge, to any person obtaining a copy
 *           of this software and associated documentation files (the "Software"), to deal
 *           in the Software without restriction, including without limitation the rights
 *           to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *           copies of the Software, and to permit persons to whom the Software is
 *           furnished to do so, subject to the following conditions:
 *
 *           The above copyright notice and this permission notice shall be included in all
 *           copies or substantial portions of the Software.
 *
 *           THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *           IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *           FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *           AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *           LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *           OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *           SOFTWARE.
 */
public class SObjectUtilFactory {
    public class SObjectUtilFactoryException extends Exception{}

    // public SObjectUtil testUtil { get; private set; }

    // public SObjectUtilFactory(String sObjectName) {
    //     this.testUtil = new SObjectUtil(sObjectName);
    // }

    // public SObjectUtilFactory(SObjectUtil theUtil) {
    //     this.testUtil = theUtil;
    // }

    /*  ****************************************  */
    /*             Private Functions              */
    /*  ****************************************  */

    /**
     * Creates and returns a random string
     * @param   Integer: The length of the string. Cannot be longer than 255
     * @return  String: Randomised string
     */
    private String getRandomString(Integer length) {
        length = Math.abs(length);
        if (length > 255) {
            length = 255;
        }

        return null;
    }

    /**
     * Creates and returns a random integer
     * @param   Integer: Max length of integer. Cannot be larger than 16
     * @return  Integer: Randomised integer
     */
    private Integer getRandomInteger(Integer length) {
        length = Math.abs(length);
        if (length > 16) {
            length = 16;
        }

        return null;
    }

    /**
     * Creates and returns a random decimal
     * @param   Integer: Max length of decimal. Cannot be larger than 16
     * @param   Integer: Number of decimal places
     * @return  Decimal: Randomised decimal
     */
    private Decimal getRandomDecimal(Integer length, Integer decimalPlaces) {
        length = Math.abs(length);
        decimalPlaces = Math.abs(decimalPlaces);
        if (length > 16) {
            length = 16;
        }

        return null;
    }

    /**
     * Creates a random date for the current year
     * @return  Date: Randomised date
     */
    private Date getRandomDate() {
        return null;
    }

    /*  ****************************************  */
    /*             Public Functions               */
    /*  ****************************************  */

    /**
     * Creates a single record with all required fields populated
     * @param   Boolean: Whether or not to insert the record
     * @return  Id: The Id of the record if inserted. Null if not inserted
     */
    public Id createSingleRecord(Boolean doInsert) {
        return null;
    }

    /**
     * Creates a single record with all required fields populated and a specific record type
     * @param   String: The developer name of the record type
     * @param   Boolean: Whether or not to insert the record
     * @return  Id: The Id of the record if inserted. Null if not inserted
     */
    public Id createSingleRecordWithType(String recordTypeName, Boolean doInsert) {
        return null;
    }

    /**
     *
     */
    public Id createSingleRecordWithFields(Set<String> fieldsToPopulate, Boolean doInsert) {
        return null;
    }

    /**
     *
     */
    public Id createSingleRecordWithTypeFields(String recordTypeName, Set<String> fieldsToPopulate, Boolean doInsert) {
        return null;
    }

    /**
     *
     */
    public Set<Id> createNRecords(Integer numberOfRecords) {
        return null;
    }

    /**
     *
     */
    public Set<Id> createNRecordsWithType(Integer numberOfRecords, String recordTypeName) {
        return null;
    }

    /**
     *
     */
    public Set<Id> createNRecordsWithFields(Integer numberOfRecords, Set<String> fieldsToPopulate) {
        return null;
    }

    /**
     *
     */
    public Set<Id> createNRecordsWithTypeFields(Integer numberOfRecords, String recordType, Set<String> fieldsToPopulate) {
        return null;
    }

}