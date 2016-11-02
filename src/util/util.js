import _ from 'underscore'
import messager from './messager'

let Myblog = {
	messager
};
let cache = {};
global._ = _;
global.Myblog = Myblog;
global.cache = cache;