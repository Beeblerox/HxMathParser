package tree;
import tree.NodeType;

class MulExprNode extends SeqExprNode
{

	public function new(?a:ExpressionNode, ?positive:Bool) 
	{
		super(a, positive);
	}
	
	override public function getType():NodeType 
	{
		return NodeType.MUL;
	}
	
	override public function getValue():Float 
	{
		var prod:Float = 1;
		for (t in terms)
		{
			if (t.positive)
			{
				prod *= t.expression.getValue();
			}
			else
			{
				prod /= t.expression.getValue();
			}
		}
		return prod;
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