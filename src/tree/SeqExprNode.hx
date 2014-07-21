package tree;

class SeqExprNode implements ExpressionNode
{
	private var terms:Array<Term>;
	
	public function new(?a:ExpressionNode, ?positive:Bool) 
	{
		terms = new Array<Term>();
		
		if (a != null)
		{
			terms.push(new Term(positive, a));
		}
	}
	
	public function add(a:ExpressionNode, positive:Bool)
	{
		terms.push(new Term(positive, a));
	}
	
	public function getType():NodeType
	{
		return NodeType.NONIMPLEMENTED;
	}
	
	public function getValue():Float
	{
		return 0;
	}
	
	public function accept(visitor:ExprNodeVisitor)
	{
		
	}
}