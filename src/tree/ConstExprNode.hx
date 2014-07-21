package tree;

/**
 * ...
 * @author 
 */
class ConstExprNode implements ExpressionNode
{
	private var value:Float;
	
	public function new(?valueS:String, ?value:Float) 
	{
		if (valueS != null)
		{
			this.value = Std.parseFloat(valueS);
		}
		else
		{
			this.value = value;
		}
	}
	
	public function getValue():Float
	{
		return value;
	}
	
	public function getType():NodeType
	{
		return NodeType.CONST;
	}
	
	public function accept(visitor:ExprNodeVisitor)
	{
		visitor.visit(this);
	}
}