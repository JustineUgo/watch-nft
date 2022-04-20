import {useContract} from './useContract';
import WatchNFTAbi from '../contracts/WatchNFT.json';
import WatchNFTContractAddress from '../contracts/WatchNFT-address.json';


// export interface for NFT contract
export const useMinterContract = () => useContract(WatchNFTAbi.abi, WatchNFTContractAddress.WatchNFT);