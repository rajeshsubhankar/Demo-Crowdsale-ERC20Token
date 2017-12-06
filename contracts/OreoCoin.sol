pragma solidity ^0.4.16;

contract Owned {
    address public owner;

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function changeOwner(address newOwner) onlyOwner public {
        owner = newOwner;
    }
}

contract OreoCoin is Owned {
    string public name;
    string public symbol;
    uint8 public decimal = 18;
    uint256 public totalSupply;
    bytes32 public currentChallenge;
    uint public timeOfLastProof;
    uint public difficulty;

    mapping( address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public frozenAccounts;

    event Transfer(address from, address to, uint256 amount);
    event Burnt(address from, uint256 amount);
    event Frozen(address target, bool isFrozen);

    function OreoCoin (
        string tokenName,
        string tokenSymbol,
        uint256 initialSupply
    ) public {
        totalSupply = initialSupply * 10 ** uint256(decimal);
        name = tokenName;
        symbol = tokenSymbol;
        timeOfLastProof = now;

        owner = msg.sender;
        balanceOf[owner] = totalSupply;

    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(from != 0x0);
        require(to != 0x0);
        require(!frozenAccounts[from]);
        require(!frozenAccounts[to]);
        require(balanceOf[from] >= amount);
        require(balanceOf[to] + amount >= amount);

        uint previousValue = balanceOf[from] + balanceOf[to];

        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        Transfer(from, to, amount); //Event

        assert(balanceOf[from] + balanceOf[to] == previousValue);
    }

    function transfer(address to, uint256 amount) public {
        _transfer(msg.sender, to, amount);
    }

    function transfer(address from, address to, uint256 amount) public returns(bool status) {
        require(allowance[msg.sender][from] >= amount);
        allowance[msg.sender][from] -= amount;

        _transfer(from, to, amount);
        return true;
    }

    function setAllowance(address spender, uint256 amount) public returns(bool status) {
        allowance[spender][msg.sender] = amount;
        return true;
    }

    function burn(uint256 amount) public returns(bool status) {
        require(balanceOf[msg.sender] >= amount);
        
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        
        Burnt(msg.sender, amount);
        
        return true;
    }

    function burnFrom(address from, uint256 amount) public returns(bool status) {
        require(allowance[msg.sender][from] >= amount);
        require(balanceOf[from] >= amount);

        balanceOf[from] -= amount;
        totalSupply -= amount;
        allowance[msg.sender][from] -= amount;

        Burnt(from, amount);

        return true;
    }

    function freezeAccount(address target, bool isFreeze) onlyOwner public {
        frozenAccounts[target] = isFreeze;
        Frozen(target, isFreeze);
    }

    function getBalance(address target) public constant returns(uint256 amount) {
        amount = balanceOf[target];
    } 

    //Needs furthur Research and Modifications
    function blockReward(uint nonce) public {
        bytes8 n = bytes8(sha256(nonce, currentChallenge));
        require(n >= bytes8(difficulty));

        uint timeSinceLastProof = now - timeOfLastProof;
        require(timeSinceLastProof >= 5 seconds);

        balanceOf[block.coinbase] += timeSinceLastProof / 60 seconds;
        totalSupply += timeSinceLastProof / 60 seconds;

        difficulty = difficulty * (10 minutes / timeSinceLastProof) + 1;
        timeOfLastProof = now;

        currentChallenge = sha256(currentChallenge, nonce, difficulty, block.blockhash(block.number - 1));
    }

}