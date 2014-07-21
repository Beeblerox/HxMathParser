package tree;

class SetVariable implements ExprNodeVisitor
{
	private var name:String;
	private var value:Float;
	
	public function new(name:String, value:Float) 
	{
		this.name = name;
		this.value = value;
	}
	
	  public function visit(
	?nodeVar:VarExprNode,
	?nodeConst:ConstExprNode,
	?nodeAdd:AddExprNode,
	?nodeMult:MulExprNode,
	?nodeExp:ExpExprNode,
	?nodeFunct:FuncExprNode)
	{
		if (nodeVar != null)
		{
			if (nodeVar.getName() == name)
			{
				nodeVar.setValue(value);
			}
		}
	}
}