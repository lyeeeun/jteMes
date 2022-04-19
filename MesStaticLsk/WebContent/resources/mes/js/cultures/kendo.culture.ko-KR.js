kendo.cultures["ko-KR"] = {
    // <language code>-<country/region code>
    name: "ko-KR",
      // The "numberFormat" defines general number formatting rules.
    numberFormat: {
        //numberFormat has only negative pattern unlike the percent and currency
        //negative pattern: one of (n)|-n|- n|n-|n -
        pattern: ["-n"],
        //number of decimal places
        decimals: 2,
        //string that separates the number groups (1,000,000)
        ",": ",",
        // A string that separates a number from the fractional point.
        ".": ".",
        //the length of each number group
        groupSize: [3],
        //formatting rules for percent number
        percent: {
            //[negative pattern, positive pattern]
            // negativePattern: one of -n %|-n%|-%n|%-n|%n-|n-%|n%-|-% n|n %-|% n-|% -n|n- %
            //positivePattern: one of n %|n%|%n|% n
            pattern: ["-n %", "n %"],
            // The number of decimal places.
            decimals: 2,
            // The string that separates the number groups (1,000,000 %).
            ",": ",",
            // The string that separates a number from the fractional point.
            ".": ".",
            // The length of each number group.
            groupSize: [3],
            //percent symbol
            symbol: "%"
        },
        currency: {
            // [negative pattern, positive pattern]
            // negativePattern: one of "($n)|-$n|$-n|$n-|(n$)|-n$|n-$|n$-|-n $|-$ n|n $-|$ n-|$ -n|n- $|($ n)|(n $)"
            //positivePattern: one of "$n|n$|$ n|n $"
            pattern: ["($n)", "$n"],
            // The number of decimal places.
            decimals: 2,
            // The string that separates the number groups (1,000,000 $).
            ",": ",",
            // The string that separates a number from the fractional point.
            ".": ".",
            // The length of each number group.
            groupSize: [3],
            // The currency symbol.
            symbol: "$"
        }
    },
    calendars: {
        standard: {
            days: {
                // The full day names.
                names: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
                // The abbreviated day names.
                namesAbbr: ["일", "월", "화", "수", "목", "금", "토"],
                // The shortest day names.
                namesShort: ["일", "월", "화", "수", "목", "금", "토"]
            },
            months: {
                // The full month names.
                names: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                // abbreviated month names
                namesAbbr: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
            },
              // The AM and PM designators.
              // [standard,lowercase,uppercase]
            AM: [ "오전", "am", "AM" ],
            PM: [ "오후", "pm", "PM" ],
              // The set of predefined date and time patterns used by the culture.
            patterns: {
                d: "M/d/yyyy",
                D: "dddd, MMMM dd, yyyy",
                F: "dddd, MMMM dd, yyyy h:mm:ss tt",
                g: "M/d/yyyy h:mm tt",
                G: "M/d/yyyy h:mm:ss tt",
                m: "MMMM dd",
                M: "MMMM dd",
                s: "yyyy'-'MM'-'ddTHH':'mm':'ss",
                S: "yyyy'-'MM'-'dd",
                t: "h:mm tt",
                T: "h:mm:ss tt",
                u: "yyyy'-'MM'-'dd HH':'mm':'ss'Z'",
                y: "MMMM, yyyy",
                Y: "MMMM, yyyy"
                
            },
              // The first day of the week (0 = Sunday, 1 = Monday, and so on).
            firstDay: 0
        }
    }
};