import web3 from './web3';

const address = "0x26de42dcde1a8ba661366ebace9fe13bef2c6d0a";
const data = require("./PayByLocation.json")
// const data = require("D:\\Projects\\Personal\\python\\10 Academy\\Week 10\\build\\contracts\\PayByLocation.json")
const abi =  data.abi;

// @ts-ignore
// web3.eth.sendTransaction({to:"0xBD6e60cB04046116a825eE2ccf9bb25c5458A6C6", from:"0x2BA3dAaA4212758b3C9B12474fced01e49b10A84", value: web3.utils.toWei('1')})
export default new web3.eth.Contract(abi, address);