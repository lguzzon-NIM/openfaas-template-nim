from function/handler import handle
from rdstdin import readLineFromStdin

proc main() =
    var user_input: string;
    if readLineFromStdin("Hello, what's your name? ", line=user_input):
        echo handle(user_input)
    else:
        echo "Something went wrong"

main()