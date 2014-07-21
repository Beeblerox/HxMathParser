package tree;

class Term
{
	public var positive:Bool;
	public var expression:ExpressionNode;
	
	public function new(positive:Bool, expression:ExpressionNode) 
	{
		this.positive = positive;
		this.expression = expression;
	}
	
}