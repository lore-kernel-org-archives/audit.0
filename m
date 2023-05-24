Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB7BC7EE23
	for <audit@archiver.kernel.org>; Wed, 24 May 2023 14:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjEXOqJ (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 24 May 2023 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjEXOqI (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 24 May 2023 10:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261CE46
        for <audit@vger.kernel.org>; Wed, 24 May 2023 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684939510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJNJYCn8uybzuAwdiZJZmDJcFbfWhzpTrRNQyb5RMUI=;
        b=W6+NE6HeRmysAGHwdkQIcOcDKQv1HfOkjXr8mNXINrH1zlX5uEcygvg6565zpABOhoQZK8
        UpvNh0sCAHxRQddPjqZ6TPe7sQ9Z0WHFGx81R0B/40X+hGAHkMn6tYVfRyuoFI9I3YchA6
        trJdDVUR+1GtYvAUtYnRX5KwZA9JMw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-dO6gL99TNB-x2FRnPuX76A-1; Wed, 24 May 2023 10:45:05 -0400
X-MC-Unique: dO6gL99TNB-x2FRnPuX76A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27688811E7F;
        Wed, 24 May 2023 14:45:05 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.34.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFBF4140E95D;
        Wed, 24 May 2023 14:45:04 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com
Cc:     audit@vger.kernel.org, Rinat Gadelshin <rgadelsh@gmail.com>
Subject: Re: Auditd doesn't receive syscalls after installation for the current shell.
Date:   Wed, 24 May 2023 10:45:04 -0400
Message-ID: <2151809.irdbgypaU6@x2>
Organization: Red Hat
In-Reply-To: <b5e87a11-7605-6745-516a-8004569bbe5d@gmail.com>
References: <b5e87a11-7605-6745-516a-8004569bbe5d@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wednesday, May 24, 2023 7:37:27 AM EDT Rinat Gadelshin wrote:
> Hello there.
> 
> It seems that the kernel doesn't send messages for syscalls of the shell
> process from which auditd is installed.
> 
> Reproducing steps (performed on Ubuntu 22.04 x86_64 on virtual box by
> `root`):
> 
> step #1: $ apt install auditd
> step #2: $ auditctl -a always,exit -F arch=b64 -S openat,renameat2,unlinkat
> step #3: $ echo t>delme;echo t2>>delme;cat delme;mv delme d;mv d
> delme;rm delme
> step #4: $ service auditd stop
> step #5: $ ausearch -f delme
> 
> There are syscalls from /usr/bin/cat, /usr/bin/mv, /usr/bin/rm but there
> are no any syscalls (openat expected)
> for /usr/bin/bash (current shell process) for the file.
> 
> If step #3 is performed from another tty, then openat syscalls
> (CREATE for the first echo and NORMAL for the second one)
> is logged for the /usr/bin/bash process.
> 
> `uname -a` returns: Linux grin-vb-ubuntu-22-0-4 5.19.0-41-generic
> #42~22.04.01-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 18 17:40:00 UTC 2 x86_64
> x86_64 x86_64 GNU/Linux
> 
> Should I open an issue for the case at
> https://github.com/linux-audit/audit-kernel ?

Are you booting with audit=1 ? If not, the install process and any before it 
are not auditable. You will only get events for processes started after audit 
enabled = 1.

-Steve



