<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260228202415 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP INDEX idx_24b9457916ba31db');
        $this->addSql('DROP INDEX idx_24b94579e3bd61ce');
        $this->addSql('DROP INDEX idx_24b94579fb7336f0');
        $this->addSql('CREATE INDEX IDX_24B94579FB7336F0E3BD61CE16BA31DBBF396750 ON sylius_messages (queue_name, available_at, delivered_at, id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP INDEX IDX_24B94579FB7336F0E3BD61CE16BA31DBBF396750');
        $this->addSql('CREATE INDEX idx_24b9457916ba31db ON sylius_messages (delivered_at)');
        $this->addSql('CREATE INDEX idx_24b94579e3bd61ce ON sylius_messages (available_at)');
        $this->addSql('CREATE INDEX idx_24b94579fb7336f0 ON sylius_messages (queue_name)');
    }
}
