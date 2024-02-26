package dao;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Test {
public static void main(String[] args) throws IOException {
	PrintWriter print = new PrintWriter(new FileWriter("data.txt", true));
	print.println("12312312");
	print.flush();
}
}
