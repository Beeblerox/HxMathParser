package tree;

class AddExprNode extends SeqExprNode
{

	public function new(?a:ExpressionNode, ?positive:Bool) 
	{
		super(a, positive);
	}
	
	override public function getType():NodeType
	{
		return NodeType.ADD;
	}
	
	override public function getValue():Float 
	{
		var sum:Float = 0;
		
		for (t in terms)
		{
			if (t.positive)
			{
				sum += t.expression.getValue();
			}
			else
			{
				sum -= t.expression.getValue();
			}
		}
		
		return sum;
	}
	
	override public function accept(visitor:ExprNodeVisitor)
	{
		visitor.visit(this);
		for (t in terms)
		{
			t.expression.accept(visitor);
		}
	}
}