import Web3 from 'web3';
window.ethereum.enable();
const metaProvider = window.web3.currentProvider;
const localProvider = "http://127.0.0.1:8545";

const web3 = new Web3(metaProvider);

export default web3;