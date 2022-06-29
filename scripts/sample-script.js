
const hre = require("hardhat");

async function main() {

  const ZombieFactory = await hre.ethers.getContractFactory("ZombieFactory");
  const greeter = await ZombieFactory.deploy();

  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
