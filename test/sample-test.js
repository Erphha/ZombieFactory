const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ZombieFactory", function () {
  it("Should work properly!", async function () {
    const ZombieFactory = await ethers.getContractFactory("ZombieFactory");
    const zombiefactory = await ZombieFactory.deploy();
    await zombiefactory.deployed();

    await zombiefactory.createRandomZombie("Erphha");
    console.log('Zombie created successfully');
  });
});
