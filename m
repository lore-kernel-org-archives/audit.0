Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B0CDB465
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 16:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJSQIJ (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 19 Oct 2023 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjJSQII (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 19 Oct 2023 12:08:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F01114
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 09:08:07 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a877e0f0d8so8279457b3.1
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697731686; x=1698336486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI5W+pLE9KGqVth74BV29gS9eZ2PToEpKLbX+gL4be8=;
        b=A1a5NDJ5lKW1N9CXouvR9FB/cKQ0dDNC/pHoAtJUm8jHi+DA3fcPtdM/YTUE8O4mzh
         +APgh7CLsmbBoxu8xIq1kCjdjMfH78b23WwxWwe4fgKFmdpH4wgXSow19+B/eInmgzG/
         n6h9RcJeBj3IT1JTcVx7KiF9WUA+vBE+2OXZufWdP7dUH7oD2BbBQkBf13CwL6MMZtMU
         hiKCZ6YNlrut02EPDoWWj4g8Jdkz3yNkU6PPusGUeb5n5mG+iyFm1m1luvF4zT5rEd96
         AWSg8JlAtD+9JLl6b2VGBQuINf/EFc+WjpztGusUe4lHCRQlnt0w/vmIT1/AG6b+p2em
         O8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731686; x=1698336486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI5W+pLE9KGqVth74BV29gS9eZ2PToEpKLbX+gL4be8=;
        b=Sy2dsRNL5qAe78nBUiUkDmET0ip0iXxQRPv74iQNihy3B8A87wsF9PQce3FKGKD399
         N28FIj2uBocor0G51TbjfKQ3tkQ8SPzCM22TLF6ecB7nD5eEcm6fwqh/kdoT5oiutoRH
         MOUa7DdbSPLpLMBMP8G6tRkjnTktR4stjSdOeuF0rTbKLRy/DD9B3qm9CwmCMbtITzk7
         wNhvvqSPJr3rR3dZA1bUV6vAj+87/xe/ehAGTPJYjgdDTBbvEOpnteL4waXi9zbYLqcZ
         uwNJ0yjHdS/mzwpVRE4rGTXAHs/bq61FBMhJEZKQncE2suGfgFWoycQ/bPUvU7O5rA00
         x+Fg==
X-Gm-Message-State: AOJu0YwtEVzwfhePugPqCMbJxAkVaZ0jEsMq6TNXJrb23qxbm+p4Ge5p
        bYFa1X4SVezTNUt1QmuZAa6a/ozT+P8JJg3P9qpy
X-Google-Smtp-Source: AGHT+IFtmUt9vNluJs75k1E3aUdlPVKSEicYauvFoAhEiSJWQHQwhIqAdDEI77LFv+iO+z7iPjVwBBSfpzl81yT1OHY=
X-Received: by 2002:a25:cf54:0:b0:d99:c500:1f23 with SMTP id
 f81-20020a25cf54000000b00d99c5001f23mr1968364ybg.3.1697731686158; Thu, 19 Oct
 2023 09:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
 <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
 <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com> <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com>
In-Reply-To: <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 19 Oct 2023 12:07:55 -0400
Message-ID: <CAHC9VhQDE43vwe2UAQCYeXuAQcdOj-evsie=spit-oXcekwNkw@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     audit@vger.kernel.org,
        Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Oct 19, 2023 at 10:52=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> > Thinking about it a bit more this morning, I think we can safely
> > ignore the non-@current case in audit_exe_compare() as the whole point
> > of the audit exe filter is to record the actions of processes
> > instantiated from that executable file; if the @current task is not
> > being logged/filtered, we shouldn't have to worry about the exe
> > filter.
>
> I did a quick stab at figuring out whether one can get there with
> non-current to begin with, but did not convince myself it is not
> possible.
>
> That said, should you repost, I think refing and unrefing mm should be a =
voided.

We have to deref current->mm to get the exe_file, but so long as we
get a reference with mmget()/mmput() it should be safe, no?

> The bug showed up with 18c91bb2d87268d23868bf13508f5bc9cf04e89a
> ("prlimit: do not grab the tasklist_lock") which converted that lock
> to task_lock. So I don't think pointing at my patch as "Fixes" is
> accurate, but I'm not going to insist. ;)

Hmm, 18c91bb2d872 doesn't look like it adds a call to task_lock(), did
you copy-n-past the wrong commit or am I missing something?  From what
I can see, the task_lock() was first introduced back in 2009 with
86f162f4c75c ("rlimits: do security check under task_lock").

--
paul-moore.com
