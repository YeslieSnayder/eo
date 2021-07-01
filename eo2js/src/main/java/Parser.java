import org.jetbrains.annotations.NotNull;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Parser {

    final static String XSL_PATH = "eo2js/src/main/resources/xsl/eo2js_parser.xsl";
    final static String LIB_PATH = "eo2js/src/main/resources/lib/std.js";

    public static void main(@NotNull String[] args) {
        if (args.length < 1) {
            System.err.println("Sorry, but you should run the program with parameters");
            System.err.println("Parameters represent paths to generated xml files");
            return;
        }

        createLib();
        try {
            TransformerFactory tf = TransformerFactory.newInstance();

            for (String path : args) {
                int startIndex = Math.max(path.lastIndexOf('/'), 0);
                int endIndex = Math.min(path.lastIndexOf(".eo.xml"), path.length());
                final String OUTPUT_JS = "eo2js/out/js/" + path.substring(startIndex, endIndex) + ".js";

                StreamSource xsl = new StreamSource(new File(XSL_PATH));
                StreamSource in = new StreamSource(new File(path));
                StreamResult out = new StreamResult(new File(OUTPUT_JS));

                Transformer trans;
                trans = tf.newTransformer(xsl);
                trans.transform(in, out);
            }
        } catch (TransformerException e) {
            e.printStackTrace();
        }
    }

    private static void createLib() {
        try {
            final String ROOT = "eo2js/out";
            final String LIB_LOCAL_PATH = ROOT + "/lib";
            final String JS_PATH = ROOT + "/js";
            Files.deleteIfExists(Path.of(LIB_LOCAL_PATH + "/std.js"));
            Files.createDirectories(Path.of(ROOT));
            Files.createDirectories(Path.of(LIB_LOCAL_PATH));
            Files.createDirectories(Path.of(JS_PATH));
            Files.copy(Path.of(LIB_PATH), Path.of(LIB_LOCAL_PATH + "/std.js"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
