package tree;

/**
 * ...
 * @author 
 */
class VarExprNode implements ExpressionNode
{
	private var name:String;
	private var value:Float;
	private var valueSet:Bool;
	
	public function new(name:String) 
	{
		this.name = name;
		valueSet = false;
	}
	
	public function getName():String
	{
		return name;
	}
	
	public function getType():NodeType
	{
		return NodeType.VAR;
	}
	
	public function setValue(value:Float)
	{
		this.value = value;
		valueSet = true;
	}
	
	public function getValue():Float
	{
		if (valueSet)
		{
			return value;
		}
		else
		{
			throw "Variable '" + name +"' was not initialized.";
		}
	}
	
	public function accept(visitor:ExprNodeVisitor)
	{
		visitor.visit(this);
	}
}