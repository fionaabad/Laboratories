import random


def RandomStringGenerator(l=12, a="abcdefghijklmnopqrstuvwxyz123456789"):
    s = "".join(random.choice(a) for i in range(l))
    return s


def BatchStringGenerator(n, a=8, b=12):
    if a < b:
        return [RandomStringGenerator(random.choice(range(a, b))) for i in range(n)]
    elif a == b:
        return [RandomStringGenerator(a) for i in range(n)]
    else:
        import sys

        sys.exit("Incorrect min and max string lengths. Try again.")


if __name__ == "__main__":  # perqe no et demani input cada cop que runs
    a = input("Enter minimum string length: ")
    b = input("Enter maximum string length: ")
    n = input("How many random strings to generate? ")

    print(BatchStringGenerator(int(n), int(a), int(b)))


l = [("adf", "SAFG", "AGD"), ("dsg", "asfg", 2344), ("egw", "safg", "afsg")]
