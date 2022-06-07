# #!/usr/bin/env python

from datetime import datetime

from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.common.by import By


def timestamp():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


# Start the browser and login with standard_user
def login(driver, user, password):
    # login
    driver.find_element(By.CSS_SELECTOR, "input[id='user-name']").send_keys(user)
    driver.find_element(By.CSS_SELECTOR, "input[id='password']").send_keys(password)
    driver.find_element(By.ID, "login-button").click()

    # checks if properly logged in
    assert (url + 'inventory.html') in driver.current_url, "Login failed"
    print(timestamp() + ' Login successful with username ' + user + ' and password ' + password)
    return driver


def add_products(driver, n_products):
    products_added = []
    for i in range(n_products):
        product_url = url + 'inventory-item.html?id={}'.format(i)
        driver.get(product_url)
        driver.find_element(By.CLASS_NAME, 'btn_inventory').click()
        products_added.append(
            driver.find_element(By.CLASS_NAME, 'inventory_details_name').text)
    print(timestamp() + ' Added: ', ', '.join(products_added))
    driver.get(url + 'cart.html')
    products_in_cart = [x.text for x in
                        driver.find_elements(By.CLASS_NAME, 'inventory_item_name')]
    print(timestamp() + ' The cart has: ', ', '.join(products_in_cart))
    assert set(products_added) <= set(products_in_cart)
    print(timestamp() + ' Products successfully added to cart')


def remove_products(driver, n_products):
    driver.get(url + "cart.html")
    products_in_cart = [x.text for x in
                        driver.find_elements(By.CLASS_NAME, 'inventory_item_name')]
    print(timestamp() + ' Removing {} products from cart'.format(n_products))
    n_products_in_cart = len(products_in_cart)
    assert (n_products <= n_products_in_cart), 'There are {} products in cart'.format(n_products_in_cart)
    buttons = driver.find_elements(By.CLASS_NAME, 'cart_button')
    products_removed = []
    for i in range(n_products):
        buttons[i].click()
        products_removed.append(products_in_cart[i])
    print(timestamp() + ' Removed: ', ', '.join(products_removed))
    assert set(products_removed) <= set(products_in_cart)
    print(timestamp() + ' Products successfully removed from cart')


if __name__ == "__main__":
    # --uncomment when running in Azure DevOps.
    options = ChromeOptions()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    driver = webdriver.Chrome(options=options)

    # driver for local test
    # driver = webdriver.Chrome(executable_path='C:\webdrivers\chromedriver.exe')

    url = 'https://www.saucedemo.com/'
    n_products = 6
    user = 'standard_user'
    password = 'secret_sauce'

    print(timestamp() + ' Starting the browser...')
    print(timestamp() + ' Browser started successfully. Navigating to the demo page to login.')
    driver.get(url)

    login(driver, user, password)
    print(timestamp() + ' Start adding ' + str(n_products) + ' products to cart')
    add_products(driver, n_products)
    print(timestamp() + ' Start removing ' + str(n_products) + ' products from cart')
    remove_products(driver, n_products)
    driver.close()
