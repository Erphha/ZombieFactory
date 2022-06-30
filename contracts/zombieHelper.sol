//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./ZombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001 ether;

    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        zombies[_zombieId].level >= _level;
        _;
    }

    function withdraw() external onlyOwner{
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);        
    }

    function setLevelUpFee(uint _fee) external onlyOwner{
        levelUpFee = _fee;
    }

    function levelUp(uint _zombieId) external payable {
        require(msg.value >= levelUpFee);
        zombies[_zombieId].level++;
    }

    function changeName(uint256 _zombieId, string calldata _newName)
        external ownerOf(_zombieId)
        aboveLevel(2, _zombieId)
    {
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint256 _zombieId, uint256 _newDna)
        external ownerOf(_zombieId)
        aboveLevel(20, _zombieId)
    {
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns(uint[] memory){
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for(uint i = 0; i < zombies.length; i++){
            if(zombieToOwner[i] == _owner){
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}
