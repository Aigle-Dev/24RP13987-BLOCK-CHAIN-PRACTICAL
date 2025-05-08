
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  try {
    const LoanDefaultRegistry = await ethers.getContractFactory("LoanDefaultRegistry");
    console.log("Contract factory obtained");
    const registry = await LoanDefaultRegistry.deploy();
    console.log("Deploy transaction initiated");
    
    if (!registry.deployTransaction) {
      console.error("Deployment transaction is undefined.");
      console.log("Registry object:", registry);
      return;
    }

    await registry.deployTransaction.wait();
    console.log("LoanDefaultRegistry deployed to:", registry.address);
  } catch (error) {
    console.error("Deployment failed:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
