import java.io.File;
import java.io.FileFilter;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import static java.lang.System.out;

public class FileLoader {
    /**
     * List out all subdirectories of the specified directory.
     * Use a lambda rather than a FileFilter
     */
    public static void listSubdirectoriesLambda(String dirName) {
        out.println("List subdirectories, using a lambda (instead of FileFilter");
        File myDir = new File(dirName);
        File[] subDirs2 = myDir.listFiles((file) -> {return file.isDirectory();});
        for(int i = 0; i < subDirs2.length; i++) {
            System.out.print(subDirs2[i].getName() + " ");
        }
        System.out.println();
    }

    /**
     * List out all subdirectories of the specified directory.
     * For this version, use a method reference.
     */
    public static void listSubdirectoriesMethodRef(String dirName) {
        out.println("List subdirectories using a method reference");
        File myDir = new File(dirName);
        File[] subDirs2 = myDir.listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return pathname.isDirectory();
            }
        });
        for(int i = 0; i < subDirs2.length; i++) {
            System.out.print(subDirs2[i].getName() + " ");
        }
        System.out.println();
    }

    /**
     * List out all files in the specified directory that have the specified extension.
     * Use a lambda rather than a FilenameFilter.
     */
    public static void listFiles(String dirName, String extension) {
        out.println("Listing all " + extension + " files");
        File dir = new File(dirName);
        File[] subDirs2 = dir.listFiles((file) -> {return file.isFile() && file.getName().endsWith(extension);});
        for(int i = 0; i < subDirs2.length; i++) {
            System.out.print(subDirs2[i].getName() + " ");
        }
        System.out.println();
    }

    public static void main(String[] args) {
        listSubdirectoriesLambda(".");
        System.out.println();
        listSubdirectoriesMethodRef(".");
        System.out.println();
        listFiles("src", "java");
    }

}