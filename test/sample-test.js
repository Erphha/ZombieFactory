const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ZombieFactory", function () {
  it("Factory test!", async function () {
    const ZombieFactory = await ethers.getContractFactory("ZombieFactory");
    const zombiefactory = await ZombieFactory.deploy();
    await zombiefactory.deployed();

    await zombiefactory.createRandomZombie("Erphha");
    console.log("Zombie created successfully");
  });

  it("Feeding test!", async function () {
    const ZombieFeeding = await ethers.getContractFactory("ZombieFeeding");
    const zombiefeeding = await ZombieFeeding.deploy();
    await zombiefeeding.deployed();
    [owner, address1, address2] = await ethers.getSigners();
    const owneraddress = address1.address;

    await zombiefeeding.setKittyContractAddress(owneraddress);
  });
});
