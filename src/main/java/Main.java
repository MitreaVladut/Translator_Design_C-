
import org.antlr.v4.runtime.*;
import java.nio.file.*;

public class Main {

    public static void main(String[] args) throws Exception {

        String fileName;

        if (args.length > 0) {
            fileName = args[0];
        } else {
            System.out.println("Usage: java Main <file.cm>");
            return;
        }

        CharStream input = CharStreams.fromFileName(fileName);

        // Lexical analysis
        CMinusLexer lexer = new CMinusLexer(input);
        lexer.removeErrorListeners();
        lexer.addErrorListener(ConsoleErrorListener.INSTANCE);

        CommonTokenStream tokens = new CommonTokenStream(lexer);

        tokens.fill();

        Vocabulary vocabulary = lexer.getVocabulary();

        for (Token token : tokens.getTokens()) {
            System.out.printf(
                    "Type: %-20s Text: %-15s Line: %d Column: %d%n",
                    vocabulary.getSymbolicName(token.getType()),
                    token.getText(),
                    token.getLine(),
                    token.getCharPositionInLine()
            );
        }
/*
        // Syntax analys    is
        CMinusParser parser = new CMinusParser(tokens);
        parser.removeErrorListeners();

        parser.addErrorListener(new BaseErrorListener() {
            @Override
            public void syntaxError(
                    Recognizer<?, ?> recognizer,
                    Object offendingSymbol,
                    int line,
                    int charPositionInLine,
                    String msg,
                    RecognitionException e) {

                System.err.println(
                        "Syntax error at line " + line +
                                ", column " + charPositionInLine +
                                ": " + msg
                );
            }
        });

        parser.program();

        if (parser.getNumberOfSyntaxErrors() == 0) {
            System.out.println("Parsing completed successfully!");
        } else {
            System.out.println("Parsing failed.");
        }*/
    }
}
