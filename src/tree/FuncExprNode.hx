package tree;

class FuncExprNode implements ExpressionNode
{
	private var func:FuncType;
	private var argument:ExpressionNode;
	
	public function new(func:FuncType, argument:ExpressionNode) 
	{
		this.func = func;
		this.argument = argument;
	}
	
	public function getType():NodeType
	{
		return NodeType.FUNC;
	}
	
	public function getValue():Float
	{
		switch (func)
		{
			case FuncType.SIN: return Math.sin(argument.getValue());
			case FuncType.COS: return Math.cos(argument.getValue());
			case FuncType.TAN: return Math.tan(argument.getValue());
			case FuncType.ASIN: return Math.asin(argument.getValue());
			case FuncType.ACOS: return Math.acos(argument.getValue());
			case FuncType.ATAN: return Math.atan(argument.getValue());
			case FuncType.SQRT: return Math.sqrt(argument.getValue());
			case FuncType.EXP: return Math.exp(argument.getValue());
			case FuncType.LN: return Math.log(argument.getValue());
			case FuncType.LOG: return Math.log(argument.getValue()) * 0.43429448190325182765;
			case FuncType.LOG2: return Math.log(argument.getValue()) * 1.442695040888963407360;
		}
		throw "Invalid function: " + func;
	}
	
	public static function stringToFunction(str:String):FuncType
	{
		if (str == "sin") return FuncType.SIN;
		if (str == "cos") return FuncType.COS;
		if (str == "tan") return FuncType.TAN;
		
		if (str == "asin") return FuncType.ASIN;
		if (str == "acos") return FuncType.ACOS;
		if (str == "atan") return FuncType.ATAN;
		
		if (str == "sqrt") return FuncType.SQRT;
		if (str == "exp") return FuncType.EXP;
		
		if (str == "ln") return FuncType.LN;
		if (str == "log") return FuncType.LOG;
		if (str == "log2") return FuncType.LOG2;
		
		throw "Unexpected Function " + str + " found";
	}
	
	public static function getAllFunctions():String
	{
		return "(sin|cos|tan|asin|acos|atan|sqrt|exp|ln|log|log2)";
	}
	
	public function accept(visitor:ExprNodeVisitor)
	{
		visitor.visit(this);
		argument.accept(visitor);
	}
}