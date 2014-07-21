package token;

class TokenInfo
{
	public var regex:EReg;
	public var token:TokenType;
	
	public function new(regex:EReg, token:TokenType)
	{
		this.regex = regex;
		this.token = token;
	}
}