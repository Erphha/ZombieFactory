//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import './ZombieHelper.sol';

contract ZombieAttack is ZombieHelper{

    uint randNonce = 0;
    uint attackVictoryProbability = 70;

    function attack(uint _zombieId, uint _targetId) external{
        
    }

    function randMod(uint _modulus) internal returns(uint){
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
    }

}