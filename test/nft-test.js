const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("WatchNFT", function () {
  this.timeout(50000);

  let watchNFT;
  let owner;
  let acc1;
  let acc2;

  this.beforeEach(async function () {
    // This is executed before each test
    // Deploying the smart contract
    const WatchNFT = await ethers.getContractFactory("WatchNFT");
    [owner, acc1, acc2] = await ethers.getSigners();

    watchNFT = await WatchNFT.deploy();
  });

  it("Should set the right owner", async function () {
    expect(await watchNFT.owner()).to.equal(owner.address);
  });

  it("Should mint one NFT", async function () {
    
    // expect(await watchNFT.balanceOf(acc1.address)).to.equal(0);

    const tokenURI = "https://example.com/1";
    const price = ethers.utils.parseUnits("1", "ether");
    await watchNFT.connect(owner).safeMint(tokenURI, price);
    await watchNFT;

    // expect(await watchNFT.balanceOf(acc1.address)).to.equal(1);
  });

  it("Should set the correct tokenURI", async function () {
    const tokenURI_1 = "https://example.com/1";
    const tokenURI_2 = "https://example.com/2";

    const price = ethers.utils.parseUnits("1", "ether");

    const tx1 = await watchNFT
      .connect(owner)
      .safeMint(tokenURI_1, price);
    await tx1.wait();
    const tx2 = await watchNFT
      .connect(owner)
      .safeMint(tokenURI_2, price);
    await tx2.wait();

    expect(await watchNFT.tokenURI(0)).to.equal(tokenURI_1);
    expect(await watchNFT.tokenURI(1)).to.equal(tokenURI_2);
  });
  it("Should buy and transfer the NFT", async function(){
    const price = ethers.utils.parseUnits("1", "ether");

    await watchNFT
    .connect(owner)
    .safeMint("https://example.com/1", price);
     await watchNFT
    .connect(acc1)
    .buyWatch( 0, {value: price});
    await watchNFT.connect(acc1).makeTransfer(acc1.address, owner.address,0);
    const _owner = await watchNFT.ownerOf(0);
    console.log(_owner, owner.address);
    await watchNFT.connect(owner).sellWatch(0)
  })
  it("Should sell the nft", async function(){
    const price = ethers.utils.parseUnits("1", "ether");

    await watchNFT
    .connect(owner)
    .safeMint("https://example.com/1", price);
     await watchNFT
    .connect(acc1)
    .buyWatch( 0, {value: price});
    await watchNFT.connect(acc1).sellWatch(0)
  })
  it("Should get the nft", async function(){
    const price = ethers.utils.parseUnits("1", "ether");

    await watchNFT
    .connect(owner)
    .safeMint("https://example.com/1", price);
     await watchNFT
    .connect(acc1)
    .getWatch(0);
  })
});
