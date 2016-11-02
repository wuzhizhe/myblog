export default {
	alert(message, cb) {
		alert(message);
		if (cb && typeof cb === 'function') {
			cb();
		}
	}
}