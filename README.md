# PrestaShop Docker Template

A reusable Docker Compose environment for PrestaShop development and staging.

## Requirements

- Docker
- Docker Compose
- Make

## Installation

After cloning this repository, create your environment file:

```bash
cp .env.example .env
```

Adjust the credentials and configuration in `.env`.

Start the containers:

```bash
make
```

Open `http://localhost:8080` (or the port configured in `.env`) and complete the PrestaShop installation in your browser.

## After Installation

1. Delete the `install` directory if it has not been removed automatically.

2. Locate the randomly generated admin directory:

   ```bash
   find data/prestashop -maxdepth 1 -type d -name 'admin*'
   ```

3. Open `compose.yaml` and adjust the admin volume mount to match your installation's directory name:

   ```yaml
   - ./data/prestashop/adminXYZ:/var/www/html/adminXYZ
   ```

   Replace `adminXYZ` with the actual directory name.

4. Comment out the initial full-directory volume mount:

   ```yaml
   # - ./data/prestashop:/var/www/html
   ```

5. Uncomment the block of fine-grained volume mounts.

6. Recreate the containers:

   ```bash
   make down
   make
   ```

7. Verify that everything works:
   - Storefront is accessible.
   - Language-specific URLs work.
   - Back office login works.
   - Installed modules and themes are available.

## Persistent Data

The Docker configuration separates the PrestaShop core from persistent shop data.

| Component | Storage |
|-----------|---------|
| PrestaShop core | Docker image |
| MySQL database | `data/mysql/` |
| Shop configuration | `data/prestashop/app/config/parameters.php` |
| Images and uploads | `data/prestashop/` |
| Modules and themes | `data/prestashop/` |
| Admin directory | `data/prestashop/adminXYZ/` |

## Docker Commands

Start the environment:

```bash
make
```

Stop the containers:

```bash
make stop
```

Start existing containers:

```bash
make start
```

Recreate the environment:

```bash
make down
make
```

View container logs:

```bash
make logs
```

## Important Notes

- Do not delete `data/mysql/` or `data/prestashop/` after installation.
- The `.env` file contains credentials and must not be committed to Git.
- Back up the database and persistent shop files before upgrading.
- Changing `PS_VERSION` alone does not perform a complete PrestaShop upgrade.
- Check the release notes and upgrade instructions before changing versions.
- Persistently mounted modules, themes and admin files may require updates alongside the PrestaShop core.
- The fine-grained volume configuration is intended for an already installed shop.

**Warning:** `make fclean` and `make re` delete persistent shop data. Do not use them unless you intend to reset the installation.