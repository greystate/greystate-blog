const KEY_DOWN = 40
const KEY_UP = 38

document.addEventListener('DOMContentLoaded', (event) => {
	const navbar = document.querySelector('.navbar')
	if (navbar) {
		navbar.addEventListener('keydown', (event) => {
			const key = event.keyCode
			switch (key) {
				case KEY_UP:
					focusPreviousItem(event)
					break
				case KEY_DOWN:
					focusNextItem(event)
					break
			}
		})
	}
})

function focusPreviousItem(event) {
	event.preventDefault()
	const link = event.target
	const submenu = link.nextElementSibling
	
	if (submenu && submenu.matches('ul')) {
		const lastChild = submenu.querySelector('li:last-child > a')
		if (lastChild) {
			lastChild.focus()
		}
	} else {
		const listItem = link.parentNode
		
		if (listItem) {
			const prevItem = listItem.previousElementSibling
			const lastItem = listItem.parentNode.lastElementChild
			const link = (prevItem || lastItem).firstElementChild
			link.focus()
		}
	}
}

function focusNextItem(event) {
	event.preventDefault()
	const link = event.target
	const submenu = link.nextElementSibling
	if (submenu && submenu.matches('ul')) {
		const firstChild = submenu.querySelector('li:first-child > a')
		if (firstChild) {
			firstChild.focus()
		}
	} else {
		const listItem = link.parentNode
		
		if (listItem) {
			const nextItem = listItem.nextElementSibling
			const firstItem = listItem.parentNode.firstElementChild
			const link = (nextItem || firstItem).firstElementChild
			link.focus()
		}
	}
}
