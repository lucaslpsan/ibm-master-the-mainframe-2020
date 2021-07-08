/**************************** REXX *********************************/
/* Author: lucsalpsan for MASTER THE MAINFRAME 2020                */
/* Date: 07/07/2021                                                */
/*******************************************************************/
"FREE FI(outdd)"
"ALLOC FI(outdd) DA('Z11657.OUTPUT(CUST16)') SHR REUSE"

out_ctr = 0                           /* Initialize # of lines written */

/*******************************************************************/
/* Generate 500 valid CC numbers                                   */
/*******************************************************************/


DO 500
  cc_gen = generate_cc()

  DO WHILE (\is_valid(cc_gen))          /* while not valid */
    cc_gen = generate_cc()
  END
  
  line_cc.1 = cc_gen

  "EXECIO 1 DISKW outdd (STEM line_cc." /* Write it to outdd   */
  out_ctr = out_ctr + 1                 /* Increment output line ctr */
END

"EXECIO 0 DISKW outdd (FINIS"           /* Closes the open file, outdd     */
SAY 'File outdd now contains ' out_ctr' lines.'

"FREE FI(outdd)"
EXIT

GENERATE_CC: /* Random cc number with 000 more 16 digits */
  cc_generated = '000'

  do 4
    random = random(1000,9999)
    cc_generated = cc_generated || random
  end

RETURN cc_generated

IS_VALID: parse arg cc

    odd_digits. = 0
    even_digits. = 0


    checksum = 0
    index = 0

    do i = length(cc) to 1 by -2
       odd_digits.index = GET_DIGIT(cc, i)
       checksum = checksum + odd_digits.index
    end


    index = 0

    do i = (length(cc) - 1) to 1 by -2
       even_digits.index = GET_DIGIT(cc, i)
    end


    do i = 1 to (length(cc) / 2)
        by2 = even_digits.i * 2
        result = 0

        do y = 1 to 2
            digit = substr(by2, y, 1)
            if(datatype(digit, 'N')) then
                result = result + digit
        end

        checksum = checksum + result
    end

RETURN checksum // 10 = 0

GET_DIGIT: parse arg num, i
    digit = substr(num, i, 1)
    index = index + 1
RETURN digit
