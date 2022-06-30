//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ZombieFactory.sol";
import "./KittyInterface.sol";

contract ZombieFeeding is ZombieFactory {
    
    KittyInterface kittyContract;

    function setKittyContractAddress(address _address) external onlyOwner{
        kittyContract = KittyInterface(_address);
    }

    function _triggerCooldwon(Zombie storage _zombie) internal{
        _zombie.readyTime = uint32(block.timestamp + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns(bool){
        return (_zombie.readyTime <= block.timestamp);
    }

    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna, string memory _species) internal {
        Zombie storage myZombie = zombies[_zombieId];
        require(msg.sender == zombieToOwner[_zombieId]);
        require(_isReady(myZombie));
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        if(uint(keccak256(abi.encodePacked(_species))) == uint(keccak256(abi.encodePacked("kitty")))){
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
        _triggerCooldwon(myZombie);
    }

    function feedOnKitty(uint _zombieId , uint _kittyId) public{
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}


