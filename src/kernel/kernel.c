int kmain()
{
    char *src = (char *)0xB8000000L;
    *src = 'M';
    src += 2;
    *src = 'D';
    return 0;
}