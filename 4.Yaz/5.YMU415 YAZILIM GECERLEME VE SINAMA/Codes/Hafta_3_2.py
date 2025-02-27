from email_validator import validate_email, EmailNotValidError
import unittest

def is_valid_email(address):
    try:
        validate_email(address)  # Geçerli değilse hata fırlatır.
        return True
    except EmailNotValidError:
        return False

class ValidatorsTestCase(unittest.TestCase):
    def test_validate_email(self):
        self.assertTrue(is_valid_email('birisi@gmail.com'))
        self.assertTrue(is_valid_email('b-risi_32@gmail.com'))
        self.assertFalse(is_valid_email('birisi?!@gmail.com'))
        self.assertFalse(is_valid_email('birisigmail.com'))
        self.assertFalse(is_valid_email('@birisigmail.com'))

if __name__ == '__main__':
    unittest.TextTestRunner().run(unittest.TestLoader().loadTestsFromTestCase(ValidatorsTestCase))
