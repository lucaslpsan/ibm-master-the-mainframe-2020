/* Main program */
cc = 0008217535439617363

/* First part */
cc_genereted = '000'

do 4
    cc_genereted = cc_genereted''random(1000,9999)
end

say cc_genereted

/* Second Part */
if(IS_VALID(cc_genereted)) then
    do
        say '###### VALID ######'
    end
else
    do
        say '###### INVALID ######'
    end

exit

IS_VALID: parse arg cc

    odd_digits. = 0
    even_digits. = 0
    
    say '----------- Odd ---------------'
    
    checksum = 0
    index = 0
    
    say length(cc)
    
    do i = length(cc) to 1 by -2 
       odd_digits.index = GET_DIGIT(cc, i)
       checksum = checksum + odd_digits.index
    end
    
    say '----------- Even -------------'
    
    index = 0
    
    do i = (length(cc) - 1) to 1 by -2 
       even_digits.index = GET_DIGIT(cc, i)
    end
    
    say '------- Checksum Odd --------'
    
    say checksum
    
    say '--- Multiply Even Digits ----'
    
    do i = 1 to (length(cc) / 2)
        by2 = even_digits.i * 2
        result = 0
        
        do y = 1 to 2
            digit = substr(by2, y, 1)
            if(datatype(digit, 'N')) then
                result = result + digit
        end
        
        checksum = checksum + result
        say result
    end
    
    say '------ Checksum + Even ------'
    
    say checksum
    
    
    say '------ Checksum Rem 10 ------'
    
    say checksum // 10
    
RETURN checksum // 10 = 0

GET_DIGIT: parse arg num, i
    digit = substr(num, i, 1)
    say digit
    index = index + 1
RETURN digit
