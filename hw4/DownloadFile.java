import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.io.BufferedInputStream;
import java.io.FileOutputStream;
public class DownloadFile {
    private static final String FILE_URL = "https://cs.nyu.edu/~av2783/pl_hw4_q5.txt";
    private static final String BKP_FILE_URL = "https://cs.nyu.edu/~av2783/pl_hw4_q5_bkp.txt";
    private static final String FILE_NAME = "pl_hw4_q5_local_copy.txt";

    public static void main(String args[]){
        try{
            reachfile(FILE_URL);
        }catch (SocketTimeoutException S){
            try{
                reachfile(BKP_FILE_URL);
            }catch (IOException I){
                System.out.println(I.getMessage());
            }
        }catch (MalformedURLException I){
            System.out.println(I.getMessage());
        }catch (FileNotFoundException I){
            System.out.println(I.getMessage());
        }catch (IOException I){
            System.out.println(I.getMessage());
        }

    }

    public static void reachfile(String FILE_URL) throws IOException,SocketTimeoutException{
        BufferedInputStream in = new BufferedInputStream(new URL(FILE_URL).openStream());
        FileOutputStream fileOutputStream = new FileOutputStream(FILE_NAME);
        byte dataBuffer[] = new byte[1024];
        int bytesRead;
        while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
            fileOutputStream.write(dataBuffer, 0, bytesRead);
        }
    }
}
