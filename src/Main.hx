package ;

import neko.Lib;
import token.*;
import tree.*;
import parser.*;

class Main 
{
	static var tokenizer:Tokenizer;
	
	static function main() 
	{	
		var parser:Parser = new Parser();
		
		var input:String = Sys.stdin().readLine();
		
		while (input != "q")
		{	
			var expr:ExpressionNode = parser.parse(input);
			//expr.accept(new SetVariable("pi", Math.PI));
			Sys.println("The value of the expression is: " + expr.getValue());
			input = Sys.stdin().readLine();
		}
	}
	
	static function setUp()
	{
		tokenizer = new Tokenizer();
		
		tokenizer.add("sin|cos|exp|ln|sqrt", TokenType.FUNC);
		tokenizer.add("\\(", TokenType.OBRACKET);
		tokenizer.add("\\)", TokenType.CBRACKET);
		tokenizer.add("\\+|-", TokenType.ADD);
		tokenizer.add("\\*|/", TokenType.MUL);
		tokenizer.add("[0-9]+", TokenType.INT);
		tokenizer.add("[a-zA-Z][a-zA-Z0-9_]*", TokenType.VAR);
	}
	
}