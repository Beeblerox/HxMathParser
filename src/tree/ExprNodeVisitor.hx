package tree;

interface ExprNodeVisitor 
{
  public function visit(
	?nodeVar:VarExprNode,
	?nodeConst:ConstExprNode,
	?nodeAdd:AddExprNode,
	?nodeMult:MulExprNode,
	?nodeExp:ExpExprNode,
	?nodeFunct:FuncExprNode):Void;
}