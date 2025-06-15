<?php

declare(strict_types=1);

namespace App\Scheduler;

use Symfony\Component\Console\Messenger\RunCommandMessage;
use Symfony\Component\Scheduler\Attribute\AsSchedule;
use Symfony\Component\Scheduler\RecurringMessage;
use Symfony\Component\Scheduler\Schedule;
use Symfony\Component\Scheduler\ScheduleProviderInterface;
use Symfony\Contracts\Cache\CacheInterface;

#[AsSchedule]
final readonly class DefaultScheduleProvider implements ScheduleProviderInterface
{
    public function __construct(
        private CacheInterface $cache,
    ) {
    }

    public function getSchedule(): Schedule
    {
        return (new Schedule())
            ->add(
                RecurringMessage::cron('* * * * *', new RunCommandMessage('sylius:remove-expired-carts')),
                RecurringMessage::cron('* * * * *', new RunCommandMessage('sylius:cancel-unpaid-orders')),
                RecurringMessage::cron('* * * * *', new RunCommandMessage('sylius:promotion:generate-coupons')),
                RecurringMessage::cron('* * * * *', new RunCommandMessage('mollie:send-payment-link')),
            )
            ->stateful($this->cache)
            ->processOnlyLastMissedRun(true)
        ;
    }
}
