package tree;

class ExpExprNode implements ExpressionNode
{
	private var base:ExpressionNode;
	private var exponent:ExpressionNode;
	
	public function new(base:ExpressionNode, exponent:ExpressionNode) 
	{
		this.base = base;
		this.exponent = exponent;
	}
	
	public function getType():NodeType
	{
		return NodeType.EXP;
	}
	
	public function getValue()
	{
		return Math.pow(base.getValue(), exponent.getValue());
	}
	
	public function accept(visitor:ExprNodeVisitor)
	{
		visitor.visit(this);
		base.accept(visitor);
		exponent.accept(visitor);
	}
}