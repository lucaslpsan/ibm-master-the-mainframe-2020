/* REXX */
say "I'm thinking of a number between 1 and 10."
secret = RANDOM(1,10)
tries = 1

do while (guess \= secret)
    say "What is your guess?"
    pull guess

    if (datatype(guess, 'N')) then /* ALL less number */
        if(datatype(guess, 'W')) then /* Whole number */
            if(guess >= 1 & guess <= 10) then /* 1-10 number */
                if (guess \= secret) then
                    do
                        say "That's not it. Try again"
                        tries = tries + 1
                    end
                else
                    nop
            else
                say "What part of 1-10 did you not understand?"
        else
            say "WHOLE numbers!!!!"
    else
        if (guess = 'QUIT') then
            do
                say "Exiting..."
                exit
            end
        else
            say "Number please!"
end
say "You got it! And it only took you" tries "tries!"
exit
