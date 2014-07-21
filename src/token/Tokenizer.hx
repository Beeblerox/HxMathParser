package token ;
import tree.FuncExprNode;

using StringTools;

class Tokenizer
{
	private var tokenInfos:Array<TokenInfo>;
	
	private var tokens:Array<Token>;
	
	public static var exprTokenizer:Tokenizer = null;
	
	public function new() 
	{
		tokenInfos = new Array<TokenInfo>();
		tokens = new Array<Token>();
	}
	
	public function getTokens():Array<Token>
	{
		return tokens;
	}
	
	public function add(regex:String, token:TokenType)
	{
		tokenInfos.push(new TokenInfo(new EReg("^("+regex+")",""), token));
	}
	
	public function tokenize(input:String)
	{
		var s:String = input.trim();
		tokens = [];
		
		while (s.length != 0)
		{
			var match:Bool = false;
			
			for (info in tokenInfos)
			{
				if (info.regex.match(s))
				{
					match = true;
					
					var value:String = info.regex.matched(0).trim();
					tokens.push(new Token(info.token, value));
					
					s = info.regex.matchedRight();
					s = s.trim();

					break;
				}
			}
			
			if (!match)
			{
				throw "Unexpected character in input: " + s;
			}
		}
	}
	
	public static function createExprTokenizer():Tokenizer
	{
		var t:Tokenizer = new Tokenizer();
		
		t.add("[+-]", TokenType.ADD);
		t.add("[*/]", TokenType.MUL);
		t.add("\\^", TokenType.RAISED);
		
		var funcs:String = FuncExprNode.getAllFunctions();
		t.add(funcs, TokenType.FUNC);
		
		t.add("\\(", TokenType.OBRACKET);
		t.add("\\)", TokenType.CBRACKET);
		t.add("[0-9]+(\\.[0-9]+)?", TokenType.INT);
		t.add("[a-zA-Z]+", TokenType.VAR);
		
		exprTokenizer = t; 
		return t;
	}
}