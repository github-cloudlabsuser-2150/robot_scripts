from bs4 import BeautifulSoup

def parse_html_logs(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        soup = BeautifulSoup(file, 'html.parser')
        
        # Find all test cases
        test_cases = soup.find_all('div', class_='test')
        
        passed_count = 0
        failed_count = 0
        errors = []

        for test in test_cases:
            status = test.find('span', class_='status').get_text(strip=True)
            if status == 'PASS':
                passed_count += 1
            elif status == 'FAIL':
                failed_count += 1
                error_message = test.find('div', class_='error').get_text(strip=True)
                errors.append(error_message)
        
        # Print summary
        print(f"Total Test Cases: {len(test_cases)}")
        print(f"Passed: {passed_count}")
        print(f"Failed: {failed_count}")
        
        # Print error messages for failed test cases
        if errors:
            print("\nError Messages:")
            for error in errors:
                print(error)

if __name__ == "__main__":
    log_file_path = 'logs/log.html'  # Update this path to your actual log file path
    parse_html_logs(log_file_path)