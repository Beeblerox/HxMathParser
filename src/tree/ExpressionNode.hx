package tree;

interface ExpressionNode 
{
	public function getType():NodeType;
	public function getValue():Float;
	public function accept(visitor:ExprNodeVisitor):Void;
}