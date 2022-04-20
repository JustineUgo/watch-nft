
<!-- ABOUT THE PROJECT -->

## About The Project

Watch NFT minter is a decentralized application that enables users to showcase a watch collection and gift their collection to other users. Anyone can mint a token and owners of tokens have the ability to gift their tokens.

Project Link: https://jocular-pothos-209fe3.netlify.app/


### :man_technologist: Technologies

Frameworks and libraries used in this project include:

* [React.js](https://reactjs.org/)
* [Hardhat](https://hardhat.org/getting-started/)
* [Solidity](https://docs.soliditylang.org/en/v0.8.11/)
* [Openzeppelin](https://openzeppelin.com/)
* [Bootstrap](https://getbootstrap.com)
* [Celo-tools](https://docs.celo.org/learn/developer-tools)


## :point_down: Getting Started

To get this project up running locally, follow these simple example steps.

### Prerequisites

You will need node and yarn installed.

### Installation

Step-by-step guide to running this NFT minter locally;

1. Clone the repo
   ```sh
   git clone https://github.com/dacadeorg/celo-nft-minter.git
   ```
2. Install NPM packages
   ```sh
   yarn install
   ```

3. Run your application
   ```sh
   yarn start
   ```

### Smart-Contract-Deployment

Step-by-step guide to redeploying the NFT smart contract using your address to enable you mint NFTs.

1. Compile the smart contract
   ```sh
   npx hardhat compile
   ```
2. Run tests on smart contract
   ```sh
   npx hardhat test
   ```
3. Update env file

* Create a file in the root directory called ".env"
* Create a key called MNEMONIC and paste in your mnemonic key. e.g
     ```js
   MNEMONIC=asdasd adeew grege egegs nbrebe fwf vwefwf wvwvwv wevw vbtbtr wcvd
   ```

4. Deploy the smart contract
   ```sh
    npx hardhat run scripts/deploy.js
   ```
5. Run the project
   ```sh
    yarn start
   ```

## :writing_hand: Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any
contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also
simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



