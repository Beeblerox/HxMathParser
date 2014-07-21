package parser;

import token.Token;
import token.Tokenizer;
import token.TokenType;
import tree.*;

class Parser
{
	var tokens:Array<Token>;
	var lookahead:Token;
	
	public function new() 
	{
		
	}
	
	public function parse(str:String):ExpressionNode
	{
		Tokenizer.createExprTokenizer().tokenize(str);
		this.tokens = Tokenizer.exprTokenizer.getTokens().copy();
		for (t in tokens)
		{
			Sys.println(t);
		}
		lookahead = this.tokens[0];
		
		var expr:ExpressionNode = expression();
		
		if (lookahead.token != TokenType.EPSILON)
		{
			throw "Unexpected symbol " + lookahead + " was found";
		}
		
		return expr;
	}
	
	private function expression():ExpressionNode
	{
		var expr:ExpressionNode = signedTerm();
		expr = sumOp(expr);
		return expr;
	}
	
	private function sumOp(expr:ExpressionNode):ExpressionNode
	{
		if (lookahead.token == TokenType.ADD)
		{
			var sum:AddExprNode;
			if (expr.getType() == NodeType.ADD)
			{
				sum = cast expr;
			}
			else
			{
				sum = new AddExprNode(expr, true);
			}
			
			var positive:Bool = lookahead.value == "+";
			nextToken();
			var t:ExpressionNode = term();
			sum.add(t, positive);
			
			return sumOp(sum);
		}
		
		return expr;
	}
	
	private function signedTerm():ExpressionNode
	{
		if (lookahead.token == TokenType.ADD)
		{
			var positive:Bool = lookahead.value == "+";
			nextToken();
			var t:ExpressionNode = term();
			if (positive)
			{
				return t;
			}
			else
			{
				return new AddExprNode(t, false);
			}
		}
		return term();
	}
	
	private function term():ExpressionNode
	{
		var f:ExpressionNode = factor();
		return termOp(f);
	}
	
	private function termOp(expression:ExpressionNode):ExpressionNode
	{
		if (lookahead.token == TokenType.MUL)
		{
			var prod:MulExprNode;
			
			if (expression.getType() == NodeType.MUL)
			{
				prod = cast expression;
			}
			else
			{
				prod = new MulExprNode(expression, true);
			}
			
			var positive:Bool = lookahead.value == "*";
			nextToken();
			var f:ExpressionNode = factor();
			prod.add(f, positive);
			
			return termOp(prod);
		}
		
		return expression;
	}
	
	private function factor():ExpressionNode
	{
		var a:ExpressionNode = argument();
		return factorOp(a);
	}
	
	private function factorOp(expression:ExpressionNode):ExpressionNode
	{
		if (lookahead.token == TokenType.RAISED)
		{
			nextToken();
			
			var exponent:ExpressionNode = factor();
			
			return new ExpExprNode(expression, exponent);
		}
		
		return expression;
	}
	
	private function argument():ExpressionNode
	{
		if (lookahead.token == TokenType.FUNC)
		{
			var func:FuncType = FuncExprNode.stringToFunction(lookahead.value);
			nextToken();
			var expr:ExpressionNode = argument();
			return new FuncExprNode(func, expr);
		}
		else if (lookahead.token == TokenType.OBRACKET)
		{
			nextToken();
			var expr:ExpressionNode = expression();
			
			if (lookahead.token != TokenType.CBRACKET)
			{
				throw "Closing brackets exprected and " + lookahead.value + " found instead";
			}
			
			nextToken();
			
			return expr;
		}
		return value();
	}
	
	private function value():ExpressionNode
	{
		if (lookahead.token == TokenType.INT)
		{
			var expr:ExpressionNode = new ConstExprNode(lookahead.value);
			nextToken();
			return expr;
		}
		if (lookahead.token == TokenType.VAR)
		{
			var expr:ExpressionNode = new VarExprNode(lookahead.value);
			nextToken();
			return expr;
		}
		if (lookahead.token == TokenType.EPSILON)
		{
			throw "Unexpected end of input";
		}
		else
		{
			throw "Unexpected symbol " + lookahead.value + " found";
		}
	}
	
	private function nextToken()
	{
		tokens.remove(tokens[0]);
		
		if (tokens.length == 0)
		{
			lookahead = new Token(TokenType.EPSILON, "");
		}
		else
		{
			lookahead = tokens[0];
		}
	}
}