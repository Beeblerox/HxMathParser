package token;

class Token
{
	public var token:TokenType;
	public var value:String;
	
	public function new(token:TokenType, value:String)
	{
		this.token = token;
		this.value = value;
	}
}